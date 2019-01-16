package com.m.matsumoto.horseracepredicationml.dataimport;

import java.util.Arrays;
import java.util.stream.Collectors;

import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataImportCommandLineRunner implements CommandLineRunner {

	// インポートファイルタイプ
	enum ImportFileType {
		/* 前日系データ */
		BEFORE_HOLDING,		// 開催データ
		BEFORE_RACE,		// レースデータ
		BEFORE_HORSE,		// 競走馬データ
		/* 成績系データ */
		RECORD_HORSE,		// 成績データ
		/* マスタ系データ */
		MASTER_JOCKER,		// 騎手データ
		MASTER_TRAINER		// 調教師データ
	};

	private ImportFileType importFileType;
	private String importFilePath;


	@Override
	public void run(String... args) throws Exception {

		ImportFileType[] values = ImportFileType.values();

		// インポートファイルタイプの説明
		String importTypeDescription = Arrays.stream(values).map(x -> x.toString()).collect(Collectors.joining("|","(", ")"));

		Options options = new Options();
		options.addOption("?", "help", false, "Print this message.");
		options.addOption("h", "help", false, "Print this message.");
		options.addOption("t", "type", true, "import file type." + importTypeDescription );
		options.addOption("f", "filePath", true, "import file path.");

		try {
			DefaultParser parser = new DefaultParser();
			CommandLine cl;
			cl = parser.parse(options, args);

			// 
			if (cl.hasOption("?") || cl.hasOption("h")) {
				showUsage(options);
				return;
			}

			// インポートファイルタイプ
			String importFileTypeName = cl.getOptionValue("t");
			if (importFileTypeName == null) {
				throw new ParseException("");
			}
			importFileType = Enum.valueOf(ImportFileType.class, importFileTypeName);

			// インポートファイルパス
			importFilePath = cl.getOptionValue("f");
			if (importFilePath == null) {
				throw new ParseException("");
			}

		} catch (ParseException | IllegalArgumentException  e) {
			showUsage(options);
		}
	}

	private void showUsage(Options options) {
		new HelpFormatter().printHelp("hrdimoprt", options);
	}

}
