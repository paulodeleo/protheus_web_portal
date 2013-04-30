#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
#include 'topconn.ch'

// Monta tela de detalhe de sc
user function portal8()

  local cHtml := ''

  Local aCabec := {}
  Local aItens := {}
  Local aLinha := {}
  Private aErros := {}
  Private lMsHelpAuto := .T.
  Private lMsErroAuto := .F.
  Private lAutoErrNoFile := .T. // para capturar erros de execauto via array

  aadd(aCabec,{"C1_NUM", HttpPost->codigo})
  aadd(aCabec,{"C1_SOLICIT","Administrador"}) //TODO: pegar o usuário logado na inclusão? não alterar?
  aadd(aCabec,{"C1_EMISSAO", CTOD(HttpPost->C1_EMISSAO)})
  aadd(aCabec,{"C1_CODCOMP", HttpPost->C1_CODCOMP})

  // Extrai itens enviados via http para array de itens
  separador = ', '
  aC1_ITEM := StrTokArr(HttpPost->C1_ITEM, separador)
  aC1_PRODUTO := StrTokArr(HttpPost->C1_PRODUTO, separador)
  aC1_QUANT := StrTokArr(HttpPost->C1_QUANT, separador)

  // Adiciona itens
  for i := 1 to len(aC1_ITEM) // pegando por aC1_ITEM mas todos os outros campos recebidos devem ter o mesmo tamnho
    aLinha := {}
    aadd(aLinha,{"C1_ITEM"   , aC1_ITEM[i], Nil})
    aadd(aLinha,{"C1_PRODUTO", aC1_PRODUTO[i], Nil})
    aadd(aLinha,{"C1_QUANT"  , val(aC1_QUANT[i]), Nil})
    aadd(aItens,aLinha) 
  next i

  //aadd(aLinha,{"C1_ITEM"   , '0001', Nil})     
  //aadd(aLinha,{"C1_PRODUTO", "0201.0090", Nil})      
  //aadd(aLinha,{"C1_QUANT"  , 10, Nil})      
  //aadd(aItens,aLinha)   

  //aItens := nil // por enquanto, por não ter nenhum item para atualizar ainda
  MSExecAuto({|x,y| mata110(x, y, 4)}, aCabec, aItens) // 4 para alteração
  If !lMsErroAuto
    HttpSession->alert := 'success'
  Else
    HttpSession->alert := 'error'
    aErros := GetAutoGRLog()
  EndIf

  _cQuery := "select SC1.*, SB1.B1_DESC from " + RetSqlName("SC1") + " SC1 "
  _cQuery += "left join " + RetSqlName("SB1") + " SB1 on "
  _cQuery += "C1_PRODUTO = B1_COD "
  _cQuery += "where SC1.D_E_L_E_T_ <> '*' AND SB1.D_E_L_E_T_ <> '*' AND C1_FILIAL = B1_FILIAL "
  _cQuery += "and SC1.C1_NUM ='" + HttpGet->codigo + "' "


  If Select('SC1') <> 0
    SC1->(DbCloseArea())
  Endif

  TcQuery _cQuery New Alias "SC1"
  dbselectarea("SC1")
  SC1->(dbgotop())

  cHtml := h_edit_sc()
  //cHtml := redirpage('/u_index.apw?modulo=compras&acao=edicao_sc&codigo='+ HttpGet->codigo)

  dbCloseArea("SC1") 
    
return cHtml