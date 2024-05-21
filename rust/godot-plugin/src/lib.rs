// Main entry point from the Godot side.
//
// Registers an Engine Singleton.
// Provides the Top-Level API to GDScript.

mod conversion;
mod signals;
mod state;

use godot::builtin::Array;
use godot::prelude::*;

use compiler::Ast;
use compiler::Compilable;
use godot::engine::Engine;

use crate::signals::*;
use crate::state::*;

// Register this plugin as a Godot Extension
struct MyExtension {}

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
#[class(base=Node, init)]
struct Api {
    base: Base<Node>,
}

#[godot_api]
impl Api {
    #[func]
    fn insert(&self, _x: i64) {
        ast().lock().unwrap().append();
        global_notify(GlobalSignals::ScriptUpdated);
    }

    #[func]
    fn get_ast() -> ASTArray {
        let ast = ast().lock().unwrap();
        ast.to_godot_ast()
    }

    #[func]
    fn get_all_sprites() -> Array<GString> {
        todo!("not implemented")
    }

    #[func]
    fn set_current_sprite(id: i64) {
        let mut state = editor_state().lock().unwrap();
        state.set_current_sprite(id);
    }

    #[func]
    fn compile() -> GString {
        let ast = ast().lock().unwrap();
        ast.compile().into()
    }
}

type ASTArray = Array<Gd<GodotASTNode>>;

trait ToGodotAst {
    fn to_godot_ast(&self) -> ASTArray;
}

impl ToGodotAst for Ast {
    fn to_godot_ast(&self) -> ASTArray {
        self.statements()
            .iter()
            .map(conversion::to_godot_ast)
            .collect::<ASTArray>()
    }
}

#[allow(dead_code)]
#[derive(GodotClass)]
#[class(init, base=Node)]
struct GodotASTNode {
    node_type: i64,
    identifier: i64,
    member_data: VariantArray,
}
