use godot::builtin::Array;
use godot::engine::Engine;
use godot::prelude::*;

use std::sync::{Mutex, OnceLock};

use compiler::Ast;
use compiler::Compilable;

// Register this plugin as a Godot Extension
struct MyExtension {}

fn ast() -> &'static Mutex<Ast> {
    static AST: OnceLock<Mutex<Ast>> = OnceLock::new();
    AST.get_or_init(|| Mutex::new(Ast::default()))
}

#[gdextension]
unsafe impl ExtensionLibrary for MyExtension {
    fn on_level_init(level: InitLevel) {
        if level == InitLevel::Scene {
            Engine::singleton()
                .register_singleton(StringName::from("API"), Api::new_alloc().upcast());
        }
    }

    fn on_level_deinit(level: InitLevel) {
        if level == InitLevel::Scene {
            let mut engine = Engine::singleton();
            let singleton_name = StringName::from("API");
            let singleton = engine
                .get_singleton(singleton_name.clone())
                .expect("cannot retrieve the engine singleton");

            engine.unregister_singleton(singleton_name);
            singleton.free();
        }
    }
}

// Implementation of the API
#[derive(GodotClass)]
#[class(base=Object, init)]
struct Api {}

#[godot_api]
impl Api {
    #[func]
    fn insert(_x: i64) {
        ast().lock().unwrap().append();
    }

    #[func]
    fn get_ast() -> Array<i64> {
        let ast = ast().lock().unwrap();
        ast.to_godot_ast()
    }

    #[func]
    fn compile() -> GString {
        let ast = ast().lock().unwrap();
        ast.compile().into()
    }
}

trait ToGodotAst {
    fn to_godot_ast(&self) -> Array<i64>;
}

impl ToGodotAst for Ast {
    fn to_godot_ast(&self) -> Array<i64> {
        self.statements()
            .iter()
            .map(to_godot_ast)
            .collect::<Array<i64>>()
    }
}

fn to_godot_ast(a: &compiler::ast::Statement) -> i64 {
    use compiler::ast::Statement;
    match a {
        Statement::Move() => 1,
        Statement::Print(_str) => 2,
        Statement::Message(_str) => 3,
    }
}
