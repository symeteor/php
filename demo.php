<?php
class demo {
  function __construct() {
    echo 'Building Object.';
    echo "\n";
  }
  function hello_world() {
    print 'Hello World!';
  }
}
$demo_object=new demo();
$demo_object->hello_world();
?>
