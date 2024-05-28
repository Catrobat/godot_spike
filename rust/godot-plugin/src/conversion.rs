use godot::prelude::*;

use compiler::Ast;

#[allow(dead_code)]
#[derive(GodotClass)]
#[class(init, base=Node)]
pub struct GodotASTNode {
    node_type: i64,
    path: Array<i64>,
    member_data: VariantArray,
}

pub type ASTArray = Array<Gd<GodotASTNode>>;
pub type PathArray = Array<i64>;

trait PathNavigatable {
    fn top() -> Self;
    fn enter(&self) -> Self;
    fn exit(&self) -> Self;
    fn next(&self) -> Self;
}

impl PathNavigatable for PathArray {
    fn top() -> Self {
        array![0]
    }

    fn enter(&self) -> Self {
        let mut new = self.clone();
        new.push(0);
        new
    }

    fn exit(&self) -> Self {
        assert!(self.len() > 0);
        let mut new = self.clone();
        new.pop();
        new
    }

    fn next(&self) -> Self {
        assert!(self.len() > 0);
        let mut new = self.clone();
        new.set(self.len() - 1, self.get(self.len() - 1).unwrap() + 1);
        new
    }
}

pub fn ast_to_godot_ast(ast: &Ast) -> ASTArray {
    let mut collect = ASTArray::new();
    let mut current_path = PathArray::top();

    for statement in ast.statements() {
        current_path = current_path.next();
        let ast_node = statement_to_godot_ast(statement, &current_path);
        collect.push(ast_node);
    }

    collect
}

pub fn statement_to_godot_ast(
    a: &compiler::ast::Statement,
    current_path: &PathArray,
) -> Gd<GodotASTNode> {
    use compiler::ast::Statement;
    let node = match a {
        Statement::MoveRandomly() => GodotASTNode {
            node_type: 1,
            path: current_path.clone(),
            member_data: array![],
        },
        Statement::MoveRelative(x, y) => GodotASTNode {
            node_type: 2,
            path: current_path.clone(),
            member_data: varray![x, y],
        },
        Statement::MoveTo(x, y) => GodotASTNode {
            node_type: 2,
            path: current_path.clone(),
            member_data: varray![x, y],
        },
        Statement::Calc(x) => GodotASTNode {
            node_type: 3,
            path: current_path.clone(),
            member_data: varray![expression_to_godot_ast(x, current_path)],
        },
    };

    Gd::from_object(node)
}

pub fn expression_to_godot_ast(
    expr: &compiler::ast::Expression,
    parent_path: &PathArray,
) -> Gd<GodotASTNode> {
    use compiler::ast::Expression;
    let current_path = parent_path.enter();

    let node = match expr {
        Expression::IntLiteral(a) => GodotASTNode {
            node_type: 1000,
            path: current_path.clone(),
            member_data: varray![a], // Literal Int
        },

        Expression::Addition(a, b) => GodotASTNode {
            node_type: 2000,
            path: current_path.clone(),
            member_data: varray![
                expression_to_godot_ast(a, &current_path),
                expression_to_godot_ast(b, &current_path.next()),
            ],
        },

        Expression::Subtraction(a, b) => GodotASTNode {
            node_type: 2001,
            path: current_path.clone(),
            member_data: varray![
                expression_to_godot_ast(a, &current_path),
                expression_to_godot_ast(b, &current_path.next())
            ],
        },

        Expression::Multiplication(a, b) => GodotASTNode {
            node_type: 2002,
            path: current_path.clone(),
            member_data: varray![
                expression_to_godot_ast(a, &current_path),
                expression_to_godot_ast(b, &current_path.next())
            ],
        },

        Expression::Division(a, b) => GodotASTNode {
            node_type: 2003,
            path: current_path.clone(),
            member_data: varray![
                expression_to_godot_ast(a, &current_path),
                expression_to_godot_ast(b, &current_path.next())
            ],
        },
    };

    Gd::from_object(node)
}
