pub mod ast;

#[derive(Default)]
pub struct Ast {
    statements: Vec<ast::Statement>,
}

impl Ast {
    pub fn append(&mut self) {
        self.statements.push(ast::Statement::MoveRandomly());
    }

    pub fn statements(&self) -> &[ast::Statement] {
        &self.statements
    }

    pub fn test() -> bool {
        false
    }
}

pub trait Compilable {
    fn compile(&self) -> String;
}

impl Compilable for Ast {
    fn compile(&self) -> String {
        let mut output = "".to_owned();
        output.push_str("extends Sprite2D\n\n");
        output.push_str("func _process(_delta):\n");

        for s in &self.statements {
            match s {
                ast::Statement::MoveRandomly() => {
                    output.push_str("  position.x = position.x + (randi() % 11) - 4\n");
                    output.push_str("  position.y = position.y + (randi() % 11) - 4\n");
                }
                _ => todo!("not implemented yet"),
            }
        }

        output.to_string()
    }
}
