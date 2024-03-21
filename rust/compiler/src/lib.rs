pub mod ast;

#[derive(Default)]
pub struct Ast {
    statements: Vec<ast::Statement>,
}

impl Ast {
    pub fn append(&mut self) {
        self.statements.push(ast::Statement::Move());
    }

    pub fn statements(&self) -> &[ast::Statement] {
        &self.statements
    }
}
