require 'rails_helper'

RSpec.describe Cat, type: :model do
  it 'should have a valid name' do
    cat = Cat.create(age: 4, gender:'Male', breed: 'sphinx', enjoys: 'Chasing butterflies in the garden')
    expect(cat.errors[:name]).to_not be_empty
  end
  it 'should have a valid age' do
    cat = Cat.create(name: 'Mary', gender:'Male', breed: 'sphinx', enjoys: 'Chasing butterflies in the garden')
    expect(cat.errors[:age]).to_not be_empty
  end
  it 'should have a valid gender' do
    cat = Cat.create(name: 'Mary', age: 4, breed: 'sphinx', enjoys: 'Chasing butterflies in the garden')
    expect(cat.errors[:gender]).to_not be_empty
  end
  it 'should have a valid breed' do
    cat = Cat.create(name: 'Mary', gender:'Male', age: 4, enjoys: 'Chasing butterflies in the garden')
    expect(cat.errors[:breed]).to_not be_empty
  end
  it 'should have a valid enjoys' do
    cat = Cat.create(name: 'Mary', gender:'Male', breed: 'sphinx', age: 4)
    expect(cat.errors[:enjoys]).to_not be_empty
  end
  it 'should be at least 10 characters long' do
    cat = Cat.create(name: 'Mary', gender:'Male', breed: 'sphinx', age: 4, enjoys: 'hurting')
    expect(cat.errors[:enjoys]).to_not be_empty
  end
end

