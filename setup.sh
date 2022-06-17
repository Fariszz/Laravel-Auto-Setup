FILE=.env

if [ -f "$FILE" ]; then
        echo "$FILE exists."
	rm .env
fi

cp .env.example .env

# config name database
echo -n "Enter a database name > "
read database
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=$database/g" .env

# config username
echo -n "Enter a username > "
read  username
sed -i "s/DB_USERNAME=root/DB_DATABASE=$username/g" .env

# config password
echo -n "Enter a password > "
read -s password
sed -i "s/DB_PASSWORD=/DB_DATABASE=$password/g" .env

echo 'Do you want to create a database in your local database (y/n):'
read choice


# create database
if [ "$choice" == 'y' ]; then
	mysql -u${username} -p${password} -e "CREATE DATABASE ${database} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
fi

# Composer Update Process
echo "Composer Update Process"
composer update

# Composer Install Process
echo "Composer Install Process"
composer install

# generate app encryption key
echo "Generate an app encryption key"
php artisan key:generate

# npm install process
echo "NPM Install Process"
npm install

# server running
echo "Server Ready"
php artisan serve
