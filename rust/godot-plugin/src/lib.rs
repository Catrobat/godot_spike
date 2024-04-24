// Main entry point from the Godot side.
//
// Registers an Engine Singleton.
// Provides the Top-Level API to GDScript.

use godot::builtin::Array;
use godot::prelude::*;

use compiler::Ast;
use compiler::Compilable;
use godot::engine::Engine;

use crate::signals::*;
use crate::state::*;

mod signals;
mod state;

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
    fn ast_add(&self, _x: i64) {
        {
            let mut state = editor_state().lock().unwrap();
            let sprite_id: SpriteID = state.get_current_sprite();
            state.project[sprite_id].ast.append();
        } // End Lock

        global_notify(GlobalSignals::ScriptUpdated);
    }

    #[func]
    fn get_ast() -> Array<i64> {
        let state = editor_state().lock().unwrap();
        let sprite_id: SpriteID = state.get_current_sprite();
        state.project[sprite_id].ast.to_godot_ast()
    }

    #[func]
    fn sprite_add(&self, path: GString) {
        {
            let mut state = editor_state().lock().unwrap();
            state.project.push(Sprite::new(&path.to_string()));
        } // End Lock

        global_notify(GlobalSignals::ScriptUpdated);
    }

    #[func]
    fn sprite_get_all() -> Array<GString> {
        let state = editor_state().try_lock().expect("could not lockie lockie");
        state.project.iter().map(|x| x.path.to_godot()).collect()
    }

    #[func]
    fn set_current_sprite(id: i64) {
        let mut state = editor_state().lock().unwrap();
        state.set_current_sprite(id as SpriteID);
    }

    #[func]
    fn compile() -> GString {
        let state = editor_state().lock().unwrap();
        //
        // TODO: Properly compile all the sprites
        state.project[0].ast.compile().into()
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

// -----------------------------------------------------------
//
