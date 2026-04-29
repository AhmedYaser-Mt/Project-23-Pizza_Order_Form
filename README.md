# 🍕 Project 23 — Pizza Order Form

> First WinForms desktop application — built with C# and .NET Framework as part of Stage Two of the programming roadmap.

---

## 🚀 Project Overview

This is the first **Windows Forms** project in the roadmap.

After completing Stage One (13 courses in C++, Algorithms, OOP, and Data Structures),
Stage Two begins with C# and .NET Framework — using desktop development as a structured learning tool.

This project is not just about pizza.

It is about understanding:

- How visual controls work
- How events connect UI to logic
- How state is managed across a form
- How clean code principles apply in a GUI environment

The application allows a user to fully customize a pizza order
and see the result update in real time — just like a real ordering system.

---

## 🖼️ Application Preview

<img width="800" height="468" alt="image" src="https://github.com/user-attachments/assets/c404c0a5-1572-420d-b68e-16c5fb10272a" />


---

## 🏗️ Application Structure

The form is organized into four selection areas and one live summary panel:

```
┌─────────────────────────────────────────────────────────┐
│  Size          Toppings               Order Summary      │
│  ─────         ────────               ─────────────      │
│  Small         Extra Cheese  Onion    Size               │
│  Medium        Mushrooms     Olives   Toppings           │
│  Large         Tomatoes      GreenP   Crust Type         │
│                                       Where To Eat       │
│  Crust Type    Where To Eat           Total Price        │
│  ─────────     ────────────                              │
│  Thin Crust    Eat In                                    │
│  Thick Crust   Take Out                                  │
│                                                          │
│          [ Order Pizza ]   [ Reset Form ]                │
└─────────────────────────────────────────────────────────┘
```

---

## ⚙️ Core Functionalities

| Feature | Description |
|---|---|
| Size Selection | Small / Medium / Large — each with its own price |
| Crust Type | Thin Crust / Thick Crust |
| Toppings | 6 options — any combination, each with its own price |
| Where To Eat | Eat In / Take Out |
| Order Summary | Updates in real time on every selection change |
| Total Price | Recalculated instantly using Tag-based pricing |
| Order Pizza | Confirmation dialog → disables all controls on confirm |
| Reset Form | Restores all defaults and re-enables controls |

---

## 🧠 Key Technical Concepts Practiced

### Controls Used
- `GroupBox` — logical grouping of related controls
- `RadioButton` — single-choice selections (Size, Crust, Where To Eat)
- `CheckBox` — multi-choice selections (Toppings)
- `Label` — dynamic display of summary and total price
- `Button` — triggering actions (order and reset)
- `MessageBox` — user confirmation and feedback

### Event-Driven Programming
Each control change is connected to an event handler.

The form responds immediately — no submit button is needed to update the summary.

```csharp
private void rbSmall_CheckedChanged(object sender, EventArgs e) => UpdateSize();
private void chkExtraChees_CheckedChanged(object sender, EventArgs e) => UpdateToppings();
```

### Tag-Based Pricing
Prices are stored directly in the `Tag` property of each control.
No hardcoded price tables. No switch statements.

```csharp
private float GetSelectedSizePrice()
{
    if (rbSmall.Checked) return Convert.ToSingle(rbSmall.Tag);
    else if (rbMedium.Checked) return Convert.ToSingle(rbMedium.Tag);
    else return Convert.ToSingle(rbLarge.Tag);
}
```

### Clean Code — Divide and Conquer
Each responsibility is isolated in its own method:

```
UpdateSize()         → reads size, updates label
UpdateCrustType()    → reads crust, updates label
UpdateToppings()     → builds toppings string, updates label
UpdateWhereToEat()   → reads dining option, updates label
UpdateTotalPrice()   → calculates and displays price
UpdateOrderSummary() → calls all update methods together
```

No single method does more than one thing.

### State Management
- **Ordering**: disables all controls — prevents changes after confirming
- **Resetting**: re-enables all controls and restores default selections

---

## 🎯 What This Project Teaches

- Real-world structure of a WinForms application
- Event-driven thinking (react to user actions)
- UI state management (enable / disable / reset)
- Clean function decomposition inside a GUI project
- Connecting visual controls to backend logic

---

## 🏁 Course Context

This project is part of:

**Course 14 — C# Level 1**
**Stage Two — Universal Programming Foundations**

It is the first project built after switching from C++ to C#,
and the first project with a graphical user interface.

The goal at this stage is not to master desktop development.

The goal is to learn how real visual programs work —
so that future web, mobile, or backend development becomes easier and clearer.

> Desktop is not the destination — it is the training ground.

---

## 🙏 Gratitude

Thank you to:

- **Programming Advices Platform**
- **Dr. Mohammed Abu-Hadhoud**

**[https://programmingadvices.com](https://programmingadvices.com)**

The roadmap does not just teach programming.

It teaches timing, progression, and how to think correctly at every stage.

---

## 🚀 What's Next?

Stage Two continues.

More C# concepts.
More WinForms projects.
Then databases, backend systems, and larger applications.

The foundation grows stronger with every project.
