#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Monta tela pós login
user function portal3()

  local cHtml := ''

  if HttpSession->logado

    RpcClearEnv()
    RpcSetEnv('99', '01')

    dbselectarea("SC1")
    SC1->(dbSetOrder(1))
    SC1->(dbgotop())
    cHtml := h_list_sc()
    dbCloseArea("SC1") 
    
  else
    cHtml := redirpage('/')
  endif
  
return cHtml