﻿
#Область ПрограммныйИнтерфейс

Функция ТекстФактическогоЗапроса(ТекстЗапроса) Экспорт

	СхемаКомпоновкиДанных = ПолучитьМакет("СКД");
	
	НаборДанных = СхемаКомпоновкиДанных.НаборыДанных.Найти("НаборДанных");
	НаборДанных.Запрос = ТекстЗапроса;
	
	НастройкиКомпоновкиДанных = СхемаКомпоновкиДанных.ВариантыНастроек["Основной"].Настройки;
	
	ИсточникДоступныхНастроек = Новый ИсточникДоступныхНастроекКомпоновкиДанных(СхемаКомпоновкиДанных);
	
	КомпоновщикНастроек = Новый КомпоновщикНастроекКомпоновкиДанных;
	КомпоновщикНастроек.Инициализировать(ИсточникДоступныхНастроек);
	КомпоновщикНастроек.ЗагрузитьНастройки(НастройкиКомпоновкиДанных);
	
	ОтчетОбъект = Новый Структура;
	ОтчетОбъект.Вставить("СхемаКомпоновкиДанных", 	СхемаКомпоновкиДанных);
	ОтчетОбъект.Вставить("КомпоновщикНастроек", 	КомпоновщикНастроек);
	
	ДополнительныеПоляПредставлений = ЗарплатаКадрыОтчеты.ПоляПредставленийКадровыхДанныхСотрудниковОтчетовПечатныхФорм();
	ЗарплатаКадрыОбщиеНаборыДанных.ЗаполнитьОбщиеИсточникиДанныхОтчета(ОтчетОбъект, ДополнительныеПоляПредставлений);
	
	ТекстФактическогоЗапроса = НаборДанных.Запрос;
	Возврат ТекстФактическогоЗапроса;
	
КонецФункции

Функция ОписаниеПолейПредставления_ДанныеУчетаВремениИСостоянийСотрудников() Экспорт

	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	&ДатаНачала КАК ДатаНачала,
	|	&ДатаОкончания КАК ДатаОкончания,
	|	Сотрудники.Ссылка КАК Сотрудник
	|ПОМЕСТИТЬ ВТСотрудники
	|ИЗ
	|	Справочник.Сотрудники КАК Сотрудники
	|{ГДЕ
	|	Сотрудники.Ссылка.* КАК Сотрудник}
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВТСотрудники.ДатаНачала КАК ДатаНачала,
	|	ВТСотрудники.ДатаОкончания КАК ДатаОкончания,
	|	ВТСотрудники.Сотрудник КАК Сотрудник
	|ПОМЕСТИТЬ Представления_ДанныеУчетаВремениИСостоянийСотрудников
	|ИЗ
	|	ВТСотрудники КАК ВТСотрудники
	|ГДЕ
	|	""ТолькоРазрешенные"" = ИСТИНА
	|	И ""ДатаНачала"" = &ДатаНачала
	|	И ""ДатаОкончания"" = &ДатаОкончания
	|	И ""МесяцДатаНачала"" = &МесяцДатаНачала
	|	И ""МесяцДатаОкончания"" = &МесяцДатаОкончания
	|	И ""ДатаАктуальности"" = &ДатаОтчета
	|	И ""РассчитыватьПлановоеВремя"" = &РассчитыватьПлановоеВремя";
	
	ИмяВТ = "ПредставленияДанныеУчетаВремениИСостоянийСотрудников";
	
	ОписаниеПолейПредставления = ОписаниеПолейПредставления(ТекстЗапроса, ИмяВТ);
	Возврат ОписаниеПолейПредставления;
	
КонецФункции

Функция ОписаниеПолейПредставления_ШтатноеРасписание(ВключатьНачисления) Экспорт
	
	ТекстЗапроса = 
	"ВЫБРАТЬ * 
	|ПОМЕСТИТЬ Представления_ШтатноеРасписание
	|ГДЕ
	|	""ТолькоРазрешенные"" = ИСТИНА
	|	И ""ДатаАктуальности"" = &ДатаАктуальности
	|	И ""ВключатьНачисления"" = " + БулевоСтрокой(ВключатьНачисления);
	
	ИмяВТ = "ПредставленияШтатноеРасписание";
	
	ОписаниеПолейПредставления = ОписаниеПолейПредставления(ТекстЗапроса, ИмяВТ);
	Возврат ОписаниеПолейПредставления;
	
КонецФункции

Функция ОписаниеПолейПредставления_СрезПоследних(ИмяРегистра) Экспорт
	
	ТекстЗапроса = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Сотрудники.Ссылка КАК Сотрудник,
	|	&Период КАК Период
	|	ПОМЕСТИТЬ ВТСотрудники
	|	ИЗ
	|		Справочник.Сотрудники КАК Сотрудники
	|	;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ * 
	|ПОМЕСТИТЬ Представления_СрезПоследних_" + ИмяРегистра + "
	|ИЗ
	|	ВТСотрудники КАК Сотрудники
	|ГДЕ
	|	""ТолькоРазрешенные"" = ИСТИНА";
	
	ИмяВТ = "ПредставленияСрезПоследних_" + ИмяРегистра;
	
	ОписаниеПолейПредставления = ОписаниеПолейПредставления(ТекстЗапроса, ИмяВТ);
	Возврат ОписаниеПолейПредставления;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ОписаниеПолейПредставления(ТекстЗапроса, ИмяВТ)
	
	ТекстФактическогоЗапроса = ТекстФактическогоЗапроса(ТекстЗапроса);
	
	ОписаниеПолейПредставления = Новый ТаблицаЗначений;
	ОписаниеПолейПредставления.Колонки.Добавить("ИмяПоля");
	ОписаниеПолейПредставления.Колонки.Добавить("ВРегИмяПоля");
	ОписаниеПолейПредставления.Колонки.Добавить("ПустоеЗначениеНаЯзыкеЗапросов");
	
	СхемаЗапроса = Новый СхемаЗапроса;
	СхемаЗапроса.УстановитьТекстЗапроса(ТекстФактическогоЗапроса);
	ЗапросПредставления = ЗарплатаКадрыОбщиеНаборыДанных.ЗапросСхемыФормирующийВТ(СхемаЗапроса, ИмяВТ);

	Для каждого Колонка Из ЗапросПредставления.Колонки Цикл
		НоваяСтрока = ОписаниеПолейПредставления.Добавить();
		НоваяСтрока.ИмяПоля = Колонка.Псевдоним;
		НоваяСтрока.ВРегИмяПоля = ВРег(НоваяСтрока.ИмяПоля);
		
		Если НоваяСтрока.ИмяПоля = "Период" Тогда
			НоваяСтрока.ПустоеЗначениеНаЯзыкеЗапросов = "ДАТАВРЕМЯ(1, 1, 1)";
		Иначе	
			НоваяСтрока.ПустоеЗначениеНаЯзыкеЗапросов = ПустоеЗначениеНаЯзыкеЗапросов(Колонка.ТипЗначения);
		КонецЕсли;	
	КонецЦикла; 
	
	Возврат ОписаниеПолейПредставления;
	
КонецФункции

Функция ПустоеЗначениеНаЯзыкеЗапросов(ОписаниеТипов)
	
	Перем ПустоеЗначение;
	
	Типы = ОписаниеТипов.Типы();
	Если Типы.Количество() = 1 Тогда
		Тип = Типы[0];
		
		Если Тип = Тип("Число") Тогда
			ПустоеЗначение = "0";
			
		ИначеЕсли Тип = Тип("Строка") Тогда
			ПустоеЗначение = """""";

		ИначеЕсли Тип = Тип("Дата") Тогда
			ПустоеЗначение = "ДАТАВРЕМЯ(1, 1, 1)";

		ИначеЕсли Тип = Тип("Булево") Тогда
			ПустоеЗначение = "ИСТИНА";

		ИначеЕсли ОбщегоНазначения.ОписаниеТипаВсеСсылки().СодержитТип(Тип) Тогда
	    	ВидОбъекта = ОбщегоНазначения.ВидОбъектаПоТипу(Тип);
			
			ПолноеИмя = Метаданные.НайтиПоТипу(Тип).ПолноеИмя();
			ИмяОбъекта = СтрРазделить(ПолноеИмя, ".")[1];
			
			Шаблон = "ЗНАЧЕНИЕ(%1.%2.ПустаяСсылка)";
			ПустоеЗначение = СтрШаблон(Шаблон, ВидОбъекта, ИмяОбъекта);
			
		Иначе
			СтроковоеПредставлениеТипа = ОбщегоНазначения.СтроковоеПредставлениеТипа(Тип);
			ТекстСообщения = НСтр("ru = 'Ошибка получения пустого значения для типа: '") + СтроковоеПредставлениеТипа;
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
		
	Иначе
		ПустоеЗначение = "НЕОПРЕДЕЛЕНО";
	КонецЕсли;
	
	Возврат ПустоеЗначение;
	
КонецФункции

Функция БулевоСтрокой(Значение)
	
	Возврат Формат(Значение, "БЛ=ЛОЖЬ; БИ=ИСТИНА");

КонецФункции

#КонецОбласти
