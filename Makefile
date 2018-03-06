all: install run logs

check_env_file:
	test -f .env || (echo "Create your .env from .env.dist first" && exit 2)

install: check_env_file
	git clone git@github.com:Darkmira/drop-master.git services/drop-master || true
	git clone git@github.com:Darkmira/drop-fleetcontrol-master.git services/drop-fleetcontrol-master || true
	git clone https://gist.github.com/alcalyn/6963659e09dbbae82b6e7737fb0e76eb services/drop-observer-tmp || true

	docker-compose up --no-deps -d master-php-fpm master-database
	docker exec -ti master-sandstone-php sh -c "composer install"
	docker exec -ti master-sandstone-database sh -c "mysql -u root -proot -e 'create database if not exists sandstone;'"
	docker exec -ti master-sandstone-php sh -c "bin/console orm:schema-tool:update --dump-sql"
	docker exec -ti master-sandstone-php sh -c "bin/console orm:schema-tool:update --force"

	docker-compose up --no-deps -d fleetcontrol-php-fpm
	docker exec -ti fleetcontrol-master-php sh -c "composer install"

run:
	docker-compose up -d

stop:
	docker-compose down

logs:
	docker-compose logs -ft

race_start:
	docker exec -ti master-sandstone-php sh -c "bin/console drop:votes:schedule"
