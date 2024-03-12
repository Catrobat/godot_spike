use std::collections::*;

pub struct Project {
    objects: Vec<Object>,
}

pub struct Object {
    messages: HashMap<String, Commands>,
}

pub struct Commands {
    commands: Vec<Statement>,
}

pub enum Statement {
    Message(Message),
    Print(Expression),
}

pub struct Message {
    from: String,
    to: String,
    contents: Expression,
}

pub enum Expression {
    Addition(Box<Expression>, Box<Expression>),
    Subtraction(Box<Expression>, Box<Expression>),
    IntLiteral(i64),
}
