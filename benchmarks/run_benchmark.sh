#!/bin/bash

# Скрипт для компиляции и запуска бенчмарков
# Сначала компилируем AOT snapshot
echo "Компилируем AOT snapshot..."
dart compile aot-snapshot benchmarks/main.dart

# Проверяем успешность компиляции
if [ $? -eq 0 ]; then
    echo "Компиляция успешно завершена!"
    echo "Запускаем AOT snapshot..."
    
    # Запускаем скомпилированный AOT snapshot
    dartaotruntime benchmarks/main.aot
    
    # Проверяем результат выполнения
    if [ $? -eq 0 ]; then
        echo "Бенчмарк успешно выполнен!"
    else
        echo "Ошибка при выполнении бенчмарка!"
        exit 1
    fi
else
    echo "Ошибка при компиляции AOT snapshot!"
    exit 1
fi
