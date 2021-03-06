<?
//Require_Once 'StrTools.php';
  $this->Load_Lib('/UE/Deps/StrTools');
  
  if(!extension_loaded('mbstring'))
    if(!dl('mbstring'))
    {
      print('SKIP could not load mbstring module');
      UnDefined();
    }
  
  Function IsAssetName($Str)
  {
    static $From =' 01234567890qwertyuiopasdfghjklzxcvbnm_QWERTYUIOPASDFGHJKLZXCVBNM-';
    static $To   ='_                                                                 '; //.Str_Repeat(' ', StrLen($From)-1);
    
    $Str=RTrim(StrTr($Str, $From, $To));
    return StrLen($Str)===0;
  }
 
  Function IsAssetClass($Str)
  {
    if(!Str_EndsWith($Str, '_C'))
      return false;
    return IsAssetName($Str);
  }
 
  Function GetAssetPath($FilePath)
  {
    $Pos = StrRPos($FilePath, '/');
    if($Pos===False)
      $Pos=StrLen($FilePath);
    $Pos=StrPos($FilePath, '.', $Pos+1);
    if($Pos===False)
      return '';
    return SubStr($FilePath, 0, $Pos);
  }
 
  Function ExtractAssetPath($FilePath)
  {
    $Pos = StrPos($FilePath, "'");
    if($Pos!==false)
    {
      $Pos2=StrRPos($FilePath, "'");
      If($Pos>=$Pos2 || $Pos2!==StrLen($FilePath)-1)
        return '';
      $Word=SubStr($FilePath, 0, $Pos); // TODO: Validate
      $FilePath=SubStr($FilePath, $Pos, -1);
    }
    $Pos = StrPos($FilePath, '/');
    if($Pos!==0)
      return '';
    $Pos = StrRPos($FilePath, '/');
    $Pos = StrPos($FilePath, '.', $Pos+1);
    if($Pos!==False)
      $FilePath=SubStr($FilePath, 0, $Pos);
      
    if(!Str_StartsWith($FilePath, '/Game/'))
      return '';
    return $FilePath;
  }
 
  Function Asset_ExtractStrings_ByHandle(&$f)
  {
    $f->Seek(0);
    $d1=$f->Read_UInt8();
    $d2=$f->Read_UInt8();
    $d3=$f->Read_UInt8();
    $d4=$f->Read_UInt8();
    
    $Res=Array();
    while(!$f->EOF())
    {
    //$d=$d4;
    //$d=$d*256+$d3;
    //$d=$d*256+$d2;
      $d=$d2;
      $d=$d*256+$d1;
      if($d4===0 && $d3===0 && $d2<100 && $d>1)
      {
        $Pos=$f->Pos();
        $Str=$f->Read($d);
        $d--;
        $z=StrPos($Str, "\0")===$d;
        if($z)
        {
        //$Res[]=SubStr($Str, 0, $d);
          $Res[$Pos]=SubStr($Str, 0, $d);
          $d-=2;
          $Pos+=$d;
        }
        $f->Seek($Pos);
        if($z)
        {
          $d1=$f->Read_UInt8();
          $d2=$f->Read_UInt8();
          $d3=$f->Read_UInt8();
          $d4=$f->Read_UInt8();
          continue;
        }
      }
      $d1=$d2;
      $d2=$d3;
      $d3=$d4;
      $d4=$f->Read_UInt8();
    }
    return $Res;
  }
  
  Function Asset_ExtractStrings1_Str(Array &$Res, String $Data)
  {
    $l=StrLen($Data);
    $i=2;
    while(true)
    {
      $i=StrPos($Data, "\0\0", $i);
      if($i===false)
        break;
      $d=Ord($Data[$i-1])*256
        +Ord($Data[$i-2])-1;
      if($d>0)
      {
        $i+=2;
        $j=StrPos($Data, "\0", $i);
        if($j===false)
          break;
        if($j===($i+$d))
        //$Res[]=SubStr($Data, $i, $d);
          $Res[$i]=SubStr($Data, $i, $d);
        $j--;
        $i=$j;
      }
      else
        $i++;
      if($d<256*2+1) // Skip spaces
        while($i<$l && Ord($Data[$i])===0)
          $i++;
    }
  }
  
  Function CheckUtf16Arr()
  {
    $Res=Str_Repeat(Chr(0), 256);
    $Res[0xD8]=Chr(1);
    $Res[0xD9]=Chr(1);
    $Res[0xDA]=Chr(1);
    $Res[0xDB]=Chr(1);
    $Res[0xDC]=Chr(2);
    $Res[0xDD]=Chr(2);
    $Res[0xDE]=Chr(2);
    $Res[0xDF]=Chr(2);
    return $Res;
  }
  
  Function CheckUtf16($Str)
  {
    return MB_Check_EnCoding($Str, 'UTF-16LE');
    static $Check=false;
    if(!$Check)
      $Check=CheckUtf16Arr();
    $l=StrLen($Str);
    $o=false;
    for($k=0; $k<$l; $k+=2)
    {
      $p = Ord($Check[Ord($Str[$k])]);
      if($o !== ($p===2))
         return false;
      $o = $p===1;
    }
    return !$o;
  }
  
  Function Asset_ExtractStrings2_Str(Array &$Res, String $Data)
  {
    $l=StrLen($Data);
    $i=2;
    $Pos_End=-1;
    while(true)
    {
      $i=StrPos($Data, "\xff\xff", $i);
      if($i===false)
        break;
      $d=Ord($Data[$i-1])*256
        +Ord($Data[$i-2]);
      $d=0xFFFF-$d;
      //if($d<256)
    //if($i===0x58A+2)
    //  echo ' <', $d ,'> ';
    //if($i%100===0) echo ' .', $i, '.', $d ,',';
      $d*=2;
      if($d>0)
      {
        $i+=2;
        if($Pos_End>=$i)
          $j=$Pos_End;
        else
          $j=StrPos($Data, "\0\0", $i);
        if($j===false)
          break;
        $Pos_End=$j;
        if((($j+$i)&1)!==0)
          $j++;
        if($j===($i+$d))
        {
          $Sub=SubStr($Data, $i, $d);
          if(CheckUtf16($Sub))
          {
            $Str=IConv('UTF-16LE', 'UTF-8//IGNORE', $Sub);
            if(IConv('UTF-8', 'UTF-16LE', $Str)===$Sub)
              $Res[$i]=$Str;
            else
              $GLOBALS['Loader']->Debug($Sub);
          }
        }
        $j--;
        $i--;
      //$i=$j;
      }
      else
        $i++;
      if($d<256*2+1) // Skip spaces
        while($i<$l && Ord($Data[$i])===0)
          $i++;
    }
    //iconv('UTF-16', 'UTF-8', $s);
  }
  
  Function Asset_ExtractStrings_ByFileName($AssetPath)
  {
    $Data=File_Get_Contents($AssetPath);
    if($Data===False || StrLen($Data)===0)
    {
      echo "[Error] Can't read file ",$AssetPath,"\n";
      return Array();
    }
    $Res=Array();
    Asset_ExtractStrings1_Str($Res ,$Data);
    Asset_ExtractStrings2_Str($Res ,$Data);
    return $Res;
  }
  
  Function Asset_ExtractStrings_ByFileName_($AssetPath)
  {
    $f=new T_Stream_File();
    $f->Assign($AssetPath);
    $f->Open(omReadOnly|omBinary);
    $Res=Asset_ExtractStrings_ByHandle($f);
    $f->Close();
    return $Res;
  }
 
?>