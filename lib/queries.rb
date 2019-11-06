conn = PG.connect( dbname: 'sql_practice' )

create_animals_table = <<-SQL 
  CREATE TABLE animals(
    id SERIAL,
    name varchar(255),
    description text,
    age int,
    diet_id int,
    PRIMARY KEY (id)
  ) 
SQL

create_foods_table = <<-SQL
  CREATE TABLE foods(
    id SERIAL,
    name varchar(255),
    description text,
    type varchar(255)
  )
SQL

add_species = <<-SQL
  ALTER TABLE animals
  ADD species varchar(255);
SQL

baboon = <<-SQL
  INSERT INTO animals(name, age, description, species, diet_id)
  VALUES
     ('Becky', 5, 'Red-rumped baboon', 'baboon', 1);
SQL

rabbit = <<-SQL
  INSERT INTO animals(name, age, description, species, diet_id)
  VALUES
     ('Rupert', 1, 'Loves to eat grass', 'hare', 2);
SQL

apple = <<-SQL
  INSERT INTO foods(name, description, type)
  VALUES
    ('Apple', 'A shiny red fruit', 'fruit')
SQL

lettuce = <<-SQL
  INSERT INTO foods(name, description, type)
  VALUES
    ('Lettuce', 'A slightly wet leaf of lettuce', 'vegetable')
SQL

get = <<-SQL
  SELECT * FROM animals
  WHERE age >= 1
  ORDER BY name DESC
SQL

update = <<-SQL
  UPDATE animals
  SET species='rabbit'
  WHERE name='Rupert'
SQL

conn.exec("DROP TABLE animals;")
conn.exec("DROP TABLE foods;")

conn.exec(create_animals_table)
conn.exec(create_foods_table)
conn.exec(add_species)
conn.exec(baboon)
conn.exec(rabbit)
conn.exec(apple)
conn.exec(lettuce)

conn.exec(update)
res = conn.exec(get)

res.each do |row|
  p row
end

