import JavaScriptKit

guard
case .object(let div) = JSObject.global.document.createElement("div")
else
{
    fatalError("Could not create elements")
}

div.innerHTML = .string("Hi Barbie!")

_ = JSObject.global.document.body.appendChild(div)
