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
        output.push_str("extends Sprite2D\n\n");
        output.push_str("func _process(_delta):\n");

        for s in &self.statements {
            match s {
                ast::Statement::Move() => {
                    output.push_str("\tposition.x = 400\n\tposition.y=500\n");
                }
                _ => todo!("not implemented yet"),
            }
        }

        //format!("{}", output.to_owned());

        "extends Sprite2D

func _ready():
    print(\"Reeady\")

func _process(_delta):
    position.x = 200
    position.y = 400
        "
        .to_owned()
    }
}
