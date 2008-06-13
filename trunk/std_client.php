<html><head><title>STD Identifier</title></head>
<body>
<h1>STD Code Identifier</h1>
<?php
$GLOBALS['THRIFT_ROOT'] = './thrift-php';
require_once($GLOBALS['THRIFT_ROOT'] . '/packages/std/STDService.php');
require($GLOBALS['THRIFT_ROOT'] . '/transport/TSocket.php');
require($GLOBALS['THRIFT_ROOT'] . '/protocol/TBinaryProtocol.php');

function lookup_number($number) {
  $transport = new TBufferedTransport(new TSocket('localhost', 9090));
  $protocol = new TBinaryProtocol($transport);
  $client = new STDServiceClient($protocol);

  $transport->open();
  $info = $client->lookup($number);
  $transport->close();
  
  return $info;
}

if(isset($_GET['phone_number'])) {
  $info = lookup_number($_GET['phone_number']);
?>
  <p>Code Prefix: <?php echo $info['code_prefix'] ?></p>
  <p>Area: <?php echo $info['area'] ?></p>
  <p>State: <?php echo $info['state'] ?></p>
<?php
} else {
?>
<p>Type in your land line phone number with STD code to identify your city and state.</p>
<form action="<?php echo $_SERVER['PHP_SELF'] ?>">
<label for="phone_number">Phone Number:</label>
<input type="text" name="phone_number" id="phone_number" value="" /><br />
<input type="submit" value="Find Info!" />
</form>
<?php
}
?>
</body>
</html>