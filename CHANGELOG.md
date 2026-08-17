## 2.0.0.beta (2026-08-10)

- Allow all attributes passed to helpers to be placed on the DOM components generated. Can now add attributes like `disabled`, `draggable`, `contenteditable` or other custom attributes.

## 1.2.1 (2026-01-30)

- Updated dummy app to Rails 8. Tests all passed and dummy application runs, with no issues.

## 1.1.3 (2024-08-27)

- Added tests for some of the components. Updated `Alert` to accept data attributes.

## 1.1.2 (2024-04-30)

- Updated various components to return a empty string vs nil, since Rails 7.2 ActiveSupport::SafeBuffer removed implicit conversion of nil to string. @see https://guides.rubyonrails.org/7_1_release_notes.html#active-support-removals

## 1.0.1 (2022-09-12)

- Added parameter to Accordions to allow users to specify the collapse component id.
