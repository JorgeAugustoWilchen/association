# db/seeds.rb

require 'faker'

# Limpa todos os registros existentes
Debt.destroy_all
Person.destroy_all
User.destroy_all

# Criação do usuário admin
admin_user = User.create(email: 'admin@admin.com', password: '111111')
puts "Usuário criado:"
puts "Login: #{admin_user.email}"
puts "Senha: #{admin_user.password}"

# Gera 50 usuários com dados falsos
3000.times do
  user = User.create(email: Faker::Internet.email, password: Faker::Internet.password)

  # Para cada usuário, cria 2 pessoas com dados falsos
  2.times do
    person = Person.create(
      name: Faker::Name.name,
      phone_number: Faker::PhoneNumber.phone_number,
      national_id: CPF.generate,
      active: [true, false].sample,
      user: user
    )

    # Para cada pessoa, cria 5 dívidas
    5.times do
      Debt.create(
        amount: Faker::Number.decimal(l_digits: 2),
        observation: Faker::Lorem.sentence,
        person: person
      )
    end
  end
end

puts "50 usuários, 100 pessoas e 500 dívidas criados com dados falsos."
