#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
#include 'topconn.ch'

// Monta tela de detalhe de sc
user function portal11()

  local cHtml := ''

  _cQuery := "select * from " + RetSqlName("SB1") + " where D_E_L_E_T_ <> '*'"

  If Select('SB1') <> 0
    SB1->(DbCloseArea())
  Endif

  TcQuery _cQuery New Alias "SB1"
  dbselectarea("SB1")
  SB1->(dbgotop())

  cHtml := h_F3Produto()

  dbCloseArea("SB1") 
    
return cHtml