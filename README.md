<div align="center">
<a href="https://github.com/1hehaq/setappimage">
  
<img src="https://github.com/user-attachments/assets/62bb4b1e-ee64-4183-9024-bc80bf353a9a" height="50%" width="50%">

</a>
</div>
  
<div align="center">

<p> 
  
**_The easiest way to integrate AppImage applications into your Linux system!_**

</p>

  <div>
    
  <a href="#installation">`installation`</a>
  <a href="#setup">`setup`</a>
  <a href="#features">`features`</a>
  <a href="#using">`usage`</a>
  <a href="#license">`license`</a>
  
  </div>

</div>


<br>
<br>


## `Features`

- [x] One-Command Setup - Transform AppImages into native-like applications
- [x] Desktop Integration - Automatic menu entries and icon extraction
- [x] Secure Installation - Proper permissions and system-wide availability
- [x] Beautiful Interface - Clear, colorful, and user-friendly interaction
- [x] Error Handling - Comprehensive validation and recovery

<br>
<br>


## `Installation`

#### ⇨ Quick Install

```bash
curl -s https://raw.githubusercontent.com/1hehaq/setappimage/main/setappimage.sh | bash
```

#### ⇨ Manual Installation

```bash
# Clone the repository
git clone https://github.com/1hehaq/setappimage.git

# Navigate to the project directory
cd setappimage

# Make executable and install
chmod +x setappimage.sh
sudo cp setappimage.sh /usr/local/bin/setappimage
```

<br>
<br>


## `Setup`

#### ⇨ Basic Usage
```bash
sudo setappimage
```

#### ⇨ Interactive Prompts
```
📂 AppImage path: ~/Downloads/MyApp.AppImage
📝 Application name: My Amazing App
```

<br>
<br>

## `Using`

#### ⇨ Example: VSCode Installation

```bash
$ sudo setappimage
📂 AppImage path: ~/Downloads/VSCode.AppImage
📝 Application name: VSCode
✨ Done! VSCode is now in your applications menu!
```

#### ⇨ Example: Obsidian Setup

```bash
$ sudo setappimage
📂 AppImage path: ~/Downloads/Obsidian.AppImage
📝 Application name: Obsidian
✨ Done! Obsidian is ready to use!
```

#### ⇨ What It Does

```
├── Makes AppImage executable
├── Moves to /opt/appimages
├── Extracts application icon
├── Creates desktop entry
└── Updates system database
```


<br>
<br>


## `Security`

#### ⇨ Features

```
├── Proper permission handling
├── Secure installation paths
├── System-wide availability
└── Comprehensive validation
```

<br>
<br>

## `License`

This project is licensed under the MIT License - see the [`LICENSE`](LICENSE) file for details.

<br>
<br>

<div align="center">
  <sub>
  
  Made with ❤️ for the Linux Community
  
  </sub>
  <sub>
  
  Built by [`1hehaq`](https://github.com/1hehaq)
  
  </sub>
</div>

