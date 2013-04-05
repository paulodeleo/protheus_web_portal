#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

/* ----------------------------------------------------------------------------
Ponto de Entrada StartWebEx( NIL ) => .T. ou .F.  

Ponto de entrada executado na inicialização de cada Working Thread ( ONSTART ) 
É a responsável por preparar o ambiente para atender às requisições WEB de links .apw
Não recebe parâmetro algum da lib , e deve retornar .T. caso tenha inicialziado com sucesso
ou .F. em caso de falha de inicialização .
---------------------------------------------------------------------------- */
USER Function StartWebEx()

// Prepara o Ambiente ERP 
conout('Preparando ambiente web, conectando ao banco de dados...')
              
RPCSetType(3) //Nao consome licenças
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01"

conout('... conectado!')

Return .T.

/* -------------------------------------------------------------------------------
Ponto de Entrada ConnectWebEx(cFnName)  => cHtml ou ""
Ponto de entrada executado imediatamente antes do processamento de uma requisição de um link .APW
Recebe como parâmetro o nome da função a ser executada, passada no link.
Deve retornar uma String, que será retornada ao ao Browser solicitante. Caso retorne uma string
em branco (vazia) , a função originalmente solicitada é executada pela lib. 
Caso contrário, a função original não é executada , e a string retornada é enviada ao Browser.
------------------------------------------------------------------------------- */
USER Function ConnectWebEx(cFnName)
Local cHtmlConn := ''
//conout('Vou executar '+cFnName)

// Unifica parametros enviados via get para post, caso já não haja nenhum com mesmo nome (o esperado)
For i := 1 to Len(HttpGet->AGETS)
  cChave = HttpGet->AGETS[i]
  if &("HttpPost->" + cChave + " == nil")
    &("HttpPost->" + cChave + " := HttpGet->" + cChave)
  endif
Next i
// Repete o mesmo de post para get...
For i := 1 to Len(HttpPost->APOST)
  cChave = HttpPost->APOST[i]
  if &("HttpGet->" + cChave + " == nil")
    &("HttpGet->" + cChave + " := HttpPost->" + cChave)
  endif
Next i

Return cHtmlConn

/* -------------------------------------------------------------------------------
Ponto de Entrada ResetWebEx(cFnName) => cHtml ou ""
Função chamada imediatamente Apos a execução de uma requisição  .APW
Recebe como parâmetro o nome da função executada, e permite também que seja acrescentado 
algo a mais no Html a ser retornado ao Browser. 
------------------------------------------------------------------------------- */
USER Function ResetWebEx(cFnName)
Local cHtmlConn := ''
//conout('Terminei de executar '+ cFnName) // não funciona, cFnName está undefined?
//conout('Terminei de executar')
Return cHtmlConn

/* -------------------------------------------------------------------------------
Ponto de Entrada FINISHWEBEX()
Função chamada no fechamendo do ambiente de uma working Thread. Apos a execução deste , 
a Thread utilizada é eliminada da memória . 
------------------------------------------------------------------------------- */
USER Function FINISHWEBEX()
conout('Finalizando a Working Thread...')
RpcClearEnv()
conout('... finalizado!')
Return

/* -------------------------------------------------------------------------------
Ponto de Entrada ENDSESSION(cSessionId) => NIL 
Ponto de entrada chamado em uma working Thread quando a session de um usuário será
eliminada da memória por time-out.  Recebe como parametro o Id de sessions de usuario 
que está sendo finalizado. 
------------------------------------------------------------------------------- */
USER Function ENDSESSION(cSessionId)
Conout("Sesssion "+cSessionId+" expirada.")
Return