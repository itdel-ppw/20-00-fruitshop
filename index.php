<?php
// access the 3rd party library
include_once('vendor/autoload.php');

// use an external class via its namespace
use Medoo\Medoo;

// create an array to configure database access
$database_config = [
  'database_type' => 'mysql',
  'server' => 'localhost',
  'database_name' => 'fruitshop_db',
  'username' => 'fsuser',
  'password' => 'fsuser0000'
];

// create a connection to the database
$database = new Medoo($database_config);

$fruits = $database->select(
    'fruit',
    ['id', 'name', 'price', 'image']
);

$ROW_SIZE = 4;
$rows = intval(sizeof($fruits) / $ROW_SIZE);
if (sizeof($fruits) % $ROW_SIZE) {
    ++$rows;
}
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset='utf-8'>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Fruits</title>
    <link rel="icon" type="image/ico" href="/images/favicon.ico">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>

<body>
    <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
        <a class="navbar-brand" href="#">FruitShop</a>
        <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.php">Home</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="about.php">About</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="cart.php">Cart</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="account.php">Accout</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="login.php">Login</a>
            </li>
        </ul>
    </nav>

    <div class="container mt-2 mb-2">
        <h1 class="text-center">One Stop FruitShop!</h1>
    </div>
    <div class="container">
        <?php
        $counter = 0;
        while ($fruits && $rows) {
            ?>
        <div class="row">
            <?php
            do {?>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-12">
                        <img class="img-fluid rounded mx-auto" src="<?=$fruits[$counter]['image']?>">
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-md-8">
                        <h5 class="font-weight-bold text-right"><?=$fruits[$counter]['name']?>
                        </h5>
                    </div>
                    <div class="col-md-4">
                        <h5 class="font-weight-bold">$<?=$fruits[$counter]['price']?>
                        </h5>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-md-12">
                        <form class="form-inline" action="edit-cart.php" method="POST">
                            <div class="form-group mx-1 ml-auto">
                                <input type="hidden" name="id" value="<?=$fruits[$counter]['id']?>">
                                <label for="pack-<?=$counter?>">Pack:</label>
                                <select class="form-control form-control-sm" name="pack" id="pack-<?=$counter?>">
                                    <option>1</option>
                                    <option>2</option>
                                    <option>3</option>
                                    <option>4</option>
                                    <option>5</option>
                                </select>
                            </div>
                            <div class="text-right">
                                <input class="btn btn-sm btn-success" type="submit" value="Buy">
                            </div>
                        </form>
                    </div>
                </div>
                <div class="row text-right">
                    <div class="col-md-12">
                        <a class="btn btn-sm btn-primary"
                            href="/restock-fruit.php?id=<?=$fruits[$counter]['id']?>">Restock</a>&nbsp;<a
                            class="btn btn-sm btn-primary"
                            href="/edit-fruit.php?id=<?=$fruits[$counter]['id']?>">Edit</a>
                    </div>
                </div>
            </div>
            <?php
            }while ((++$counter) % $ROW_SIZE) ?>
        </div>
        <?php --$rows;
        }?>
    </div>
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-2 offset-md-10">
                <a class="btn btn-sm btn-secondary btn-block" href="add-fruit.php">New Fruit</a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous">
    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous">
    </script>
</body>

</html>