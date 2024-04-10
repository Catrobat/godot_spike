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

        for s in &self.statements {
            match s {
                ast::Statement::Move() => {
                    output.push_str(
                        "# move block
                         position.x = randi() % 500
                         position.y = randi() % 500\n",
                    );
                }
                _ => todo!("not implemented yet"),
            }
        }

        format!("func _physics_process():\n {}\n", output)
    }
}
