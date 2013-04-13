#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Verifica se um usuário está logado, exceto se o módulo acessado é justamente o de login
// Se o usuário não estiver autenticado, redireciona para a tela de login
user function verifica_login()
  local cHtmlConn := ''
  if !HttpSession->logado .or. HttpSession->logado == nil
    nPosicaoEncontrada := at('/u_index.apw?modulo=login', HttpHeadIn->aHeaders[1])
    if nPosicaoEncontrada == 0 .or. nPosicaoEncontrada > 6 // url de login não foi encontrada ou não está no inicio
      cHtmlConn := redirpage('/u_index.apw?modulo=login')
    endif
  endif
return cHtmlConn

// Troca empresa e filial se foram enviadas por http
user function TrocaEmpresa()

  // Definindo empresa 99 filial 01 por padrão nos combos do portal
  if HttpSession->empresa == nil .or. HttpSession->filial == nil
    HttpSession->empresa := '99'
    HttpSession->filial := '01'

    //PREPARE ENVIRONMENT EMPRESA HttpSession->empresa FILIAL HttpSession->filial
    RpcClearEnv()
    RpCSetType(3) //Nao consome licenças
    RpcSetEnv(HttpSession->empresa, HttpSession->filial, '','', 'SIGAFAT', ,{'SC1'})
    
  endif

  // Definindo empresa e filial conforme enviados por http
  if HttpGet->empresa != nil .and. HttpGet->filial != nil
    HttpSession->empresa := HttpGet->empresa
    HttpSession->filial := HttpGet->filial

    //PREPARE ENVIRONMENT EMPRESA HttpSession->empresa FILIAL HttpSession->filial
    RpcClearEnv()
    RpCSetType(3) //Nao consome licenças
    RpcSetEnv(HttpSession->empresa, HttpSession->filial, '','', 'SIGAFAT', ,{'SC1'})

  endif

return