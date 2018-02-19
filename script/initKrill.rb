ENV["RAILS_ENV"] = "production"
def initKrill
  Krill::Server.new.run(3501)
end
