-- Defina os caminhos
local haxeProjectPath = "FunkinCompiler/scripts/haxe/app"
local androidProjectPath = "FunkinCompiler/preload/android/build"
local buildOutputPath = haxeProjectPath .. "/export/android/bin"

-- Função para executar comandos no terminal
local function runCommand(command)
    local handle = io.popen(command)
    local result = handle:read("*a")
    handle:close()
    return result
end

-- 1. Compile o projeto Haxe para Android
print("Compilando o projeto Haxe para Android...")
local haxeCommand = "haxe -main Main -java " .. buildOutputPath .. " -D android"
local haxeResult = runCommand(haxeCommand)

if haxeResult:find("Error") then
    print("Erro durante a compilação do projeto Haxe:")
    print(haxeResult)
    os.exit(1)
else
    print("Compilação do projeto Haxe concluída com sucesso.")
end

-- 2. Copie os arquivos compilados para o projeto Android
print("Copiando arquivos compilados para o projeto Android...")

local javaOutputPath = buildOutputPath .. "/java"
local destJavaPath = androidProjectPath .. "/app/src/main/java"

local copyCommand = "cp -r " .. javaOutputPath .. "/* " .. destJavaPath
local copyResult = runCommand(copyCommand)

if copyResult ~= "" then
    print("Erro ao copiar os arquivos:")
    print(copyResult)
    os.exit(1)
else
    print("Arquivos copiados com sucesso.")
end

-- 3. Opcionalmente, você pode querer ajustar os arquivos do build.gradle ou manifest.xml
-- Se precisar de ajustes adicionais, faça as modificações aqui

print("Build do projeto Android pronto para ser executado.")
