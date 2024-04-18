// "Server-Side" state of the Godot Project.
//
// Keeps a hold of the currently selected project,
// script, etc.
//
// TODO: Rethink wheter this is really the best way to do this,
// or whether we should just send the full selector down with
// every call from the GDScript side.

use std::sync::{Mutex, OnceLock};

use compiler::Ast;

pub fn ast() -> &'static Mutex<Ast> {
    static AST: OnceLock<Mutex<Ast>> = OnceLock::new();
    AST.get_or_init(|| Mutex::new(Ast::default()))
}

#[derive(Default)]
pub struct EditorState {
    current_sprite: Option<i64>,
}

impl EditorState {
    pub fn set_current_sprite(&mut self, id: i64) {
        // TODO: Validate whether sprite_id is valid!
        self.current_sprite = Some(id);
    }
}

pub fn editor_state() -> &'static Mutex<EditorState> {
    static EDITOR_STATE: OnceLock<Mutex<EditorState>> = OnceLock::new();
    EDITOR_STATE.get_or_init(|| Mutex::new(EditorState::default()))
}
