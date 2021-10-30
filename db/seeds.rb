
cats = [
	{
		name: "Felix",
		age: 2,
        gender: "male"
        breed: "Tabby"
		enjoys: "Long naps by the fire"

	},
	{
		name: "Lola",
		age: 5,
        gender: "Female"
        breed: "Tuxedo"
		enjoys: "hairball fetish"
	},
	{
		name: "Toast",
		age: 5,
        gender: "Male"
        breed: "Calico"
		enjoys: "warm butter"
	},
    {
        name: "Cheese Ball",
        age: 1,
        gender: "Male"
        breed: "Orange Tabby"
        enjoys: "Enjoy's being spun by the tail"
    }


cats.each do |attributes|
	Cat.create attributes
	p "creating cats #{attributes}"
end
