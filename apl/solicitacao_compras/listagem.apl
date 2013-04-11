#include "protheus.ch"
#include "apwebex.ch"
#include "tbiconn.ch"

// Monta tela pós login
user function portal3()

  local cHtml := ''

BEGINSQL ALIAS 'SC1'
  SELECT *
  FROM %table:SC1% SC1
  WHERE SC1.%notDel%
  ORDER BY C1_NUM DESC, C1_ITEM
ENDSQL

  dbselectarea("SC1")
  
  SC1->(dbgotop())
  cHtml := h_list_sc()
  dbCloseArea("SC1") 
    
return cHtml