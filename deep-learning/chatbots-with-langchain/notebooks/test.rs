struct User {
    name: String,
    email: String,
}

impl User {
    fn new(name: &String) -> User {
        User {
            name: name.to_string(),
            email: format!("{}")
    }
}