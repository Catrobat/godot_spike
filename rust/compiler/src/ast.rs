use std::collections::*;

#[allow(dead_code)]
pub struct Project {
    objects: Vec<Object>,
}

#[allow(dead_code)]
pub struct Object {
    messages: HashMap<String, Commands>,
}

#[allow(dead_code)]
pub struct Commands {
    commands: Vec<Statement>,
}

#[derive(Clone)]
pub enum Statement {
    Move(),
    Message(Message),
    Print(Expression),
}

#[allow(dead_code)]
#[derive(Clone)]
pub struct Message {
    from: String,
    to: String,
    contents: Expression,
}

#[derive(Clone)]
pub enum Expression {
    Addition(Box<Expression>, Box<Expression>),
    Subtraction(Box<Expression>, Box<Expression>),
    Multiplication(Box<Expression>, Box<Expression>),
    Division(Box<Expression>, Box<Expression>),
    IntLiteral(i64),
}
