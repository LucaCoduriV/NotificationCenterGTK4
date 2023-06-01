#![allow(
    non_camel_case_types,
    unused,
    clippy::redundant_closure,
    clippy::useless_conversion,
    clippy::unit_arg,
    clippy::double_parens,
    non_snake_case,
    clippy::too_many_arguments
)]
// AUTO GENERATED FILE, DO NOT EDIT.
// Generated by `flutter_rust_bridge`@ 1.75.1.

use crate::api::*;
use core::panic::UnwindSafe;
use flutter_rust_bridge::*;
use std::ffi::c_void;
use std::sync::Arc;

// Section: imports

use crate::dbus::DeamonAction;
use crate::notification::Hints;
use crate::notification::ImageData;
use crate::notification::Notification;
use crate::notification::Picture;
use crate::notification::Urgency;

// Section: wire functions

fn wire_setup_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "setup",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| Ok(setup()),
    )
}
fn wire_start_deamon_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "start_deamon",
            port: Some(port_),
            mode: FfiCallMode::Stream,
        },
        move || move |task_callback| start_deamon(task_callback.stream_sink()),
    )
}
fn wire_stop_deamon_impl(port_: MessagePort) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "stop_deamon",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || move |task_callback| stop_deamon(),
    )
}
fn wire_send_deamon_action_impl(
    port_: MessagePort,
    action: impl Wire2Api<DeamonAction> + UnwindSafe,
) {
    FLUTTER_RUST_BRIDGE_HANDLER.wrap(
        WrapInfo {
            debug_name: "send_deamon_action",
            port: Some(port_),
            mode: FfiCallMode::Normal,
        },
        move || {
            let api_action = action.wire2api();
            move |task_callback| send_deamon_action(api_action)
        },
    )
}
// Section: wrapper structs

// Section: static checks

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

pub trait Wire2Api<T> {
    fn wire2api(self) -> T;
}

impl<T, S> Wire2Api<Option<T>> for *mut S
where
    *mut S: Wire2Api<T>,
{
    fn wire2api(self) -> Option<T> {
        (!self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<chrono::DateTime<chrono::Utc>> for i64 {
    fn wire2api(self) -> chrono::DateTime<chrono::Utc> {
        let Timestamp { s, ns } = wire2api_timestamp(self);
        chrono::DateTime::<chrono::Utc>::from_utc(
            chrono::NaiveDateTime::from_timestamp_opt(s, ns)
                .expect("invalid or out-of-range datetime"),
            chrono::Utc,
        )
    }
}

impl Wire2Api<bool> for bool {
    fn wire2api(self) -> bool {
        self
    }
}

impl Wire2Api<i32> for i32 {
    fn wire2api(self) -> i32 {
        self
    }
}
impl Wire2Api<i64> for i64 {
    fn wire2api(self) -> i64 {
        self
    }
}

impl Wire2Api<u32> for u32 {
    fn wire2api(self) -> u32 {
        self
    }
}
impl Wire2Api<u8> for u8 {
    fn wire2api(self) -> u8 {
        self
    }
}

impl Wire2Api<Urgency> for i32 {
    fn wire2api(self) -> Urgency {
        match self {
            0 => Urgency::Low,
            1 => Urgency::Normal,
            2 => Urgency::Critical,
            _ => unreachable!("Invalid variant for Urgency: {}", self),
        }
    }
}
impl Wire2Api<usize> for usize {
    fn wire2api(self) -> usize {
        self
    }
}
// Section: impl IntoDart

impl support::IntoDart for DeamonAction {
    fn into_dart(self) -> support::DartAbi {
        match self {
            Self::Show(field0) => vec![0.into_dart(), field0.into_dart()],
            Self::ShowNc => vec![1.into_dart()],
            Self::CloseNc => vec![2.into_dart()],
            Self::Close(field0) => vec![3.into_dart(), field0.into_dart()],
            Self::Update(field0, field1) => {
                vec![4.into_dart(), field0.into_dart(), field1.into_dart()]
            }
            Self::FlutterClose(field0) => vec![5.into_dart(), field0.into_dart()],
            Self::FlutterCloseAll => vec![6.into_dart()],
            Self::FlutterActionInvoked(field0, field1) => {
                vec![7.into_dart(), field0.into_dart(), field1.into_dart()]
            }
        }
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for DeamonAction {}
impl support::IntoDart for Hints {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.actions_icon.into_dart(),
            self.category.into_dart(),
            self.desktop_entry.into_dart(),
            self.resident.into_dart(),
            self.sound_file.into_dart(),
            self.sound_name.into_dart(),
            self.suppress_sound.into_dart(),
            self.transient.into_dart(),
            self.x.into_dart(),
            self.y.into_dart(),
            self.urgency.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Hints {}

impl support::IntoDart for ImageData {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.width.into_dart(),
            self.height.into_dart(),
            self.rowstride.into_dart(),
            self.one_point_two_bit_alpha.into_dart(),
            self.bits_per_sample.into_dart(),
            self.channels.into_dart(),
            self.data.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for ImageData {}

impl support::IntoDart for Notification {
    fn into_dart(self) -> support::DartAbi {
        vec![
            self.id.into_dart(),
            self.app_name.into_dart(),
            self.replaces_id.into_dart(),
            self.summary.into_dart(),
            self.body.into_dart(),
            self.actions.into_dart(),
            self.timeout.into_dart(),
            self.created_at.into_dart(),
            self.hints.into_dart(),
            self.app_icon.into_dart(),
            self.app_image.into_dart(),
        ]
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Notification {}

impl support::IntoDart for Picture {
    fn into_dart(self) -> support::DartAbi {
        match self {
            Self::Data(field0) => vec![0.into_dart(), field0.into_dart()],
            Self::Path(field0) => vec![1.into_dart(), field0.into_dart()],
        }
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Picture {}

impl support::IntoDart for Urgency {
    fn into_dart(self) -> support::DartAbi {
        match self {
            Self::Low => 0,
            Self::Normal => 1,
            Self::Critical => 2,
        }
        .into_dart()
    }
}
impl support::IntoDartExceptPrimitive for Urgency {}

// Section: executor

support::lazy_static! {
    pub static ref FLUTTER_RUST_BRIDGE_HANDLER: support::DefaultHandler = Default::default();
}

#[cfg(not(target_family = "wasm"))]
#[path = "bridge_generated.io.rs"]
mod io;
#[cfg(not(target_family = "wasm"))]
pub use io::*;
