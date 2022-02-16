import Foundation

struct Products {
    let name: String
    let image: String
    let description: String
    let price: Int
    
    static func getData() -> [Products] {
        return [
            Products(name: "Butter Chicken Butter Chicken Butter Chicken Butter Chicken", image: "butterChicken", description: "To make this delicious preparation, the chicken is first marinated in yogurt, then browned in a pan before being drenched in a tomato gravy thick with spices like turmeric and garam masala, and of course, plenty of cream.", price: 30),
            Products(name: "Chole Bhature", image: "choleBhature", description: "One of the most popular vegetarian North Indian recipes, chole refers to the spicy garbanzo bean and tomato gravy.", price: 24),
            Products(name: "Curry", image: "curry", description: "If you ask any Indian about a curry, chances are they’ll reply, “Which one?", price: 15),
            Products(name: "Biryani", image: "hyderabadi", description: "If there’s one dish that almost everyone knows in Indian cuisine, it’s biryani. The origin of this aromatic mixture of rice, spices and meat is usually credited to the Mughal kings who once ruled the subcontinent, but it’s now a popular dish all over the country. The meat (and vegetables, if used) and rice are cooked separately before being layered and cooked together with a mixture of spices. The type of meat used varies; goat, chicken, beef, lamb, fish or prawns are used according to the region, with eggs and potatoes sometimes added as well.", price: 50),
            
            Products(name: "Lamb Saag", image: "lambSaang", description: "Saag is a term widely used in the northern region of Punjab for any leafy green vegetable dish, and in several regions nearby, including Bengal and Assam in the east.", price: 30),
            Products(name: "Mughlai Butter Chicken", image: "mughlaiChicken", description: "To make this delicious preparation, the chicken is first marinated in yogurt, then browned in a pan before being drenched in a tomato gravy thick with spices like turmeric and garam masala, and of course, plenty of cream.", price: 30),
            Products(name: "Rogan Josh", image: "roganJosh", description: "Made for the cold climate of Kashmir, the northernmost state in India, the name rogan josh likely comes from the Urdu words for “red meat.” This spicy braised dish usually uses lamb or mutton and gets its signature color from a large amount of lal mirch (Kashmiri red chilis). Milder than the usual Indian chilis, their paprika-like taste makes this dish a great starting point for anyone new to Indian cuisine.", price: 30)
        ]
    }
}
