use godot::prelude::*;

use crate::GodotASTNode;

pub fn to_godot_ast(a: &compiler::ast::Statement) -> Gd<GodotASTNode> {
    use compiler::ast::Statement;
    let node = match a {
        Statement::MoveRandomly() => GodotASTNode {
            node_type: 1,
            identifier: -1, // TODO
            member_data: array![],
        },
        Statement::MoveRelative(x, y) => GodotASTNode {
            node_type: 2,
            identifier: -1, // TODO
            member_data: varray![x, y],
        },
        Statement::MoveTo(x, y) => GodotASTNode {
            node_type: 2,
            identifier: -1, // TODO
            member_data: varray![x, y],
        },
        Statement::Calc(x) => GodotASTNode {
            node_type: 3,
            identifier: -1,
            member_data: varray![expression_to_godot_ast(x)],
        },
    };

    Gd::from_object(node)
}

pub fn expression_to_godot_ast(expr: &compiler::ast::Expression) -> Gd<GodotASTNode> {
    use compiler::ast::Expression;

    let node = match expr {
        Expression::IntLiteral(a) => GodotASTNode {
            node_type: 1000,
            identifier: -1,
            member_data: varray![a], // Literal Int
        },

        Expression::Addition(a, b) => GodotASTNode {
            node_type: 2000,
            identifier: -1,
            member_data: varray![expression_to_godot_ast(a), expression_to_godot_ast(b)],
        },

        Expression::Subtraction(a, b) => GodotASTNode {
            node_type: 2001,
            identifier: -1,
            member_data: varray![expression_to_godot_ast(a), expression_to_godot_ast(b)],
        },

        Expression::Multiplication(a, b) => GodotASTNode {
            node_type: 2002,
            identifier: -1,
            member_data: varray![expression_to_godot_ast(a), expression_to_godot_ast(b)],
        },

        Expression::Division(a, b) => GodotASTNode {
            node_type: 2003,
            identifier: -1,
            member_data: varray![expression_to_godot_ast(a), expression_to_godot_ast(b)],
        },
    };

    Gd::from_object(node)
}
