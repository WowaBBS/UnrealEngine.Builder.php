<?
  if(file_exists(__DIR__.'/WLib/Using.php'))
    Include_Once('WLib/Using.php');
  else
    return Include_Once '_Using.php';
  
  $Loader->AddSearchPath(__DIR__);
?>