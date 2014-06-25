require 'sqlite3'

class User
  attr_reader :name, :login_id, :reg_number, :category, :comments, :extragroups, :extraalias, :ucla_logon
  def initialize attributes
    attributes.each do |k, v|
      if self.respond_to? k
        unless v.nil?
          self.instance_variable_set("@#{k}", v)
        end
      end
    end
  end 

  def create
    begin
      db = SQLite3::Database.new "test.db"
      db.transaction
      
      stm = db.prepare "INSERT INTO user ( name, login_id, reg_number, category, comments, extragroups, extraalias, ucla_logon ) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)"
      stm.bind_param 1, @name
      stm.bind_param 2, @login_id
      stm.bind_param 3, @reg_number
      stm.bind_param 4, @category
      stm.bind_param 5, @comments
      stm.bind_param 6, @extragroups
      stm.bind_param 7, @extraalias
      stm.bind_param 8, @ucla_logon

      stm.execute
      db.commit
    rescue SQLite3::Exception => e
      db.rollback
      return e
    ensure
      stm.close if stm
      db.close if db
    end

  end
end