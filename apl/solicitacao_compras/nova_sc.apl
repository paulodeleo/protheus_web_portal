#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
#include 'topconn.ch'

// Monta tela de criação de SC
user function portal12()

  local cHtml := ''

  // Xunxo para garantir que uma área está aberta antes de chamar UsrRetName()/UsrFullName(), senão dá erro...
  Select('SC1')
  private C1_SOLICIT := UsrRetName(HttpSession->UserId)
  private C1_EMISSAO := CTOD('02/05/2013')
  cHtml := h_nova_sc()

return cHtml