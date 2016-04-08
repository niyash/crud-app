require 'mysql'
class CRUD
	def initialize(host, username, password, db)
		@con = Mysql.new(host, username, password, db)
		if !@con
			puts"There was a problem while connecting to the database"
		end
	end

	def create_user(name, password)
		    stmt = @con.prepare "INSERT INTO users(name, password) VALUES(?, ?)"
		     stmt.execute(name, password)
	end

	def select_all()
		rows = @con.query "SELECT * FROM users"
		rows.each do |row|
			puts row.join("\t")
		end
	end

	def select_by_id(id)
		single_row = @con.prepare"SELECT * FROM users WHERE id = ?"
		single_row.execute(id)
		single_row.each do |row|
			puts row.join("\t")
		end

	end 

	def update(name, password, id)
		    stmt = @con.prepare "UPDATE users SET name = ?, password = ?  WHERE id = ?"
		    stmt.execute(name, password, id)
		    puts"Person with id of #{id} has been updated successfully"
	end

	def delete(id)
		stmt = @con.prepare"DELETE from users where id = ?"
		stmt.execute(id)
		puts"User with id of #{id} has been successfully deleted"
	end
end
#user = CRUD.new('localhost', 'root', 'toor', 'Test')
#user.create_user('first user', 'mypass')
#user.select_all
#user.update('updated name', 'updatedpassword', 10)
#user.select_all
#user.delete(10)
#user.select_all

