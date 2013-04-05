#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Monta tela pós login
user function portal3()

  local cHtml := ''

  dbselectarea("SC1")
  SC1->(dbSetOrder(1))
  SC1->(dbgotop())
  cHtml := h_list_sc()
  dbCloseArea("SC1") 
    
return cHtml