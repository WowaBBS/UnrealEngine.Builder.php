<?
  Function Str_StartsWith(String $Str, String $SubStr):bool
  {
    $SubStr_Len=StrLen($SubStr);
    if($SubStr_Len===0)
      return true;
    if(StrLen($Str)<$SubStr_Len)
      return false;
    if(SubStr($Str, 0, $SubStr_Len)!==$SubStr)
      return false;
    return true;
  }
 
  Function Str_EndsWith(String $Str, String $SubStr):bool
  {
    $SubStr_Len=StrLen($SubStr);
    if($SubStr_Len===0)
      return true;
    if(StrLen($Str)<$SubStr_Len)
      return false;
    if(SubStr($Str, -$SubStr_Len, $SubStr_Len)!==$SubStr)
      return false;
    return true;
  }
?>