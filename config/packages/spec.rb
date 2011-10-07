package :sphinx2, :provides => :spec do
  description "Start Apache server"
  noop {}
  verify { has_executable 'searchd' }
end