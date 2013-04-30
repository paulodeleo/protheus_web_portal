#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
#include 'topconn.ch'

// Monta tela de detalhe de sc
user function portal7()

  local cHtml := ''

  _cQuery := "select SC1.*, SB1.B1_DESC, SY1.Y1_NOME "
  _cQuery += "from " + RetSqlName("SC1") + " SC1 "
  _cQuery += "left join " + RetSqlName("SB1") + " SB1 on "
  _cQuery += "C1_PRODUTO = B1_COD "
  _cQuery += "left join " + RetSqlName("SY1") + " SY1 on "
  _cQuery += "C1_CODCOMP = Y1_COD "
  _cQuery += "where SC1.D_E_L_E_T_ <> '*' AND SB1.D_E_L_E_T_ <> '*' "
  _cQuery += "AND C1_FILIAL = B1_FILIAL "
  _cQuery += "and SC1.C1_NUM ='" + HttpGet->codigo + "' "

  If Select('SC1') <> 0
    SC1->(DbCloseArea())
  Endif

  TcQuery _cQuery New Alias "SC1"
  dbselectarea("SC1")
  SC1->(dbgotop())

  cHtml := h_edit_sc()

  dbCloseArea("SC1") 
    
return cHtml