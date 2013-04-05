#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Monta tela pós login
user function portal3()
  local cHtml := ''
  if HttpSession->logado
    cHtml := h_list_sc()
  else
    cHtml := redirpage('/')
  endif
return cHtml