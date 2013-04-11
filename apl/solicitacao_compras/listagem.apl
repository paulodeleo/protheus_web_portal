#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"
#include 'topconn.ch'

// Monta tela pós login, de listagem de SC
user function portal3()

  local cHtml := ''

  _cQuery := "select * from " + RetSqlName("SC1") + " where D_E_L_E_T_ <> '*' "
  if HttpGet->status == '1'
    _cQuery += "and C1_FLAGGCT = 1 "
  elseif HttpGet->status == '2'
    _cQuery += "and C1_TIPO = 2 "
  elseif HttpGet->status == '3'
    _cQuery += "and C1_RESIDUO <> '' "
  elseif HttpGet->status == '4'
    _cQuery += "and C1_QUJE = 0 and C1_COTACAO = Space(Len(C1_COTACAO)) and C1_APROV in (' ','L') "
  elseif HttpGet->status == '5'
    _cQuery += "and C1_QUJE = 0 and C1_COTACAO = Space(Len(C1_COTACAO)) and C1_APROV = 'R' "
  elseif HttpGet->status == '6'
    _cQuery += "and C1_QUJE = 0 and C1_COTACAO = Space(Len(C1_COTACAO)) and C1_APROV = 'B' "
  elseif HttpGet->status == '7'
    _cQuery += "and C1_QUJE = C1_QUANT "
  elseif HttpGet->status == '8'
    _cQuery += "and C1_QUJE > 0 "
  elseif HttpGet->status == '9'
    _cQuery += "and C1_QUJE = 0 and C1_COTACAO <> Space(Len(C1_COTACAO)) and C1_IMPORT <> 'S' " 
  elseif HttpGet->status == '10'
    _cQuery += "and C1_QUJE = 0 and C1_COTACAO <> Space(Len(C1_COTACAO)) and C1_IMPORT = 'S' and C1_APROV in (' ','L') "
  endif
  _cQuery += "ORDER BY C1_NUM DESC, C1_ITEM "

  If Select('SC1') <> 0
    SC1->(DbCloseArea())
  Endif

  TcQuery _cQuery New Alias "SC1"
  dbselectarea("SC1")
  SC1->(dbgotop())

  cHtml := h_list_sc()

  dbCloseArea("SC1") 
    
return cHtml