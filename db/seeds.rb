# users (10)
Agenda.destroy_all
User.destroy_all
Task.destroy_all

puts "Creating users"
matt = User.find_or_create_by(name: "Matt")
brook = User.find_or_create_by(name: "Brook")
mary = User.find_or_create_by(name: "Mary")
ashley = User.find_or_create_by(name: "Ashley")
martin = User.find_or_create_by(name: "Martin")
meli = User.find_or_create_by(name: "Meli")
agusto = User.find_or_create_by(name: "Agusto")
mark = User.find_or_create_by(name: "Mark")
sophia = User.find_or_create_by(name: "Sophia")
clara = User.find_or_create_by(name: "Clara")

puts "Created Users"

# tasks (10)
t1 = Task.find_or_create_by(name: "cleaning", complete: true)
t2 = Task.find_or_create_by(name: "homework", complete: false)
t3 = Task.find_or_create_by(name: "meditate", complete: true)
t4 = Task.find_or_create_by(name: "gym", complete: true)
t5 = Task.find_or_create_by(name: "cooking", complete: false)
t6 = Task.find_or_create_by(name: "meeting", complete: true)
t7 = Task.find_or_create_by(name: "work", complete: false)
t8 = Task.find_or_create_by(name: "yoga", complete: true)
t9 = Task.find_or_create_by(name: "reading", complete: false)
t10 = Task.find_or_create_by(name: "organize", complete: true)

# agendas (10)

a1 = Agenda.find_or_create_by(user_id: matt.id, task_id: t1.id)
a2 = Agenda.find_or_create_by(user_id: brook.id, task_id: t2.id)
a3 = Agenda.find_or_create_by(user_id: mary.id, task_id: t3.id)
a4 = Agenda.find_or_create_by(user_id: ashley.id, task_id: t4.id)
a5 = Agenda.find_or_create_by(user_id: martin.id, task_id: t5.id)
a6 = Agenda.find_or_create_by(user_id: meli.id, task_id: t6.id)
a7 = Agenda.find_or_create_by(user_id: agusto.id, task_id: t7.id)
a8 = Agenda.find_or_create_by(user_id: mark.id, task_id: t8.id)
a9 = Agenda.find_or_create_by(user_id: sophia.id, task_id: t9.id)
a10 = Agenda.find_or_create_by(user_id: clara.id, task_id: t10.id)
