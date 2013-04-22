#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
#include 'topconn.ch'

// Monta tela de detalhe de sc
user function portal9()

  local cHtml := ''

  _cQuery := "select * from " + RetSqlName("SY1") + " where D_E_L_E_T_ <> '*'"

  If Select('SY1') <> 0
    SY1->(DbCloseArea())
  Endif

  TcQuery _cQuery New Alias "SY1"
  dbselectarea("SY1")
  SY1->(dbgotop())

  cHtml := h_f3()

  dbCloseArea("SY1") 
    
return cHtml