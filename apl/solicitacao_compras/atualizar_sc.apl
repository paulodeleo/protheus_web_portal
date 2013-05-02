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
  aCamposItem := {'C1_ITEM', 'C1_PRODUTO', 'C1_QUANT', 'C1_D_E_L_E_T_'} // lista de campos de itens que serão recebidos com final "_x" sendo x a numeração
  For i := 1 to val(HttpPost->total_itens) // campo de controle de qtd de itens recebidos
    aLinha := {}
    For j := 1 to len(aCamposItem)
      cCampo := aCamposItem[j]
      cValor := ''
      // Atribui o valor do campo via macro substituição. O código executado será algo como: 
      // cValor := HttpPost->C1_ITEM_1
      cMacroSub := 'cValor := HttpPost->' + cCampo + '_' + cvaltochar(i)
      &(cMacroSub)
      // Trata exceções, como campos numéricos
      if cCampo == "C1_QUANT"
        cValor := val(alltrim(cValor))
      else
        cValor := alltrim(cValor)
      endif
      // Adiciona campo ao item a ser atualizado
      aadd(aLinha,{cCampo, cValor,  Nil})
    Next j
    // Adiciona linha de item a ser atualizado
    aadd(aItens,aLinha) 
  Next i

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