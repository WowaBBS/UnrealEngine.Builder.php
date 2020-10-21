<?
  $DefBy=['Inc'=>1, 'Set'=>null];

  $Key =$_REQUEST['Key' ]?? $argv[1]?? '';
  $If  =$_REQUEST['If'  ]?? $argv[2]?? null;
  $Op  =$_REQUEST['Op'  ]?? $argv[3]?? 'Inc'; // Inc, Set
  $By  =$_REQUEST['By'  ]?? $argv[4]?? $DefBy[$Op]?? null;
  $Min =$_REQUEST['Min' ]?? $argv[5]?? null;

  $File=FOpen('Counter.dat', 'c+');
  FLock($File, LOCK_EX);
  $Str=Stream_Get_Contents($File);
  FSeek($File, 0);
  
  $Vars=StrLen($Str)? Json_Decode($Str, True):[];
  $Value=$OldValue=$Vars[$Key]?? 0;
  If(!Is_Null($Min)&& $Value<$Min)
    $Value=$Min;
  if($OldValue==$If)
    Switch($Op)
    {
    Case 'Inc': $Value+=$By; Break;
    Case 'Set': $Value =$By; Break;
    }
  Else
    Echo '#';
  $Vars[$Key]=$Value;
  
  if($Value!==$OldValue)
  {
    $Str=Json_Encode($Vars, JSON_PRETTY_PRINT);
    FWrite($File, $Str);
    FTruncate($File, StrLen($Str));
  }
  FLock($File, LOCK_UN);
  FClose($File);
  Echo $Value;
?>