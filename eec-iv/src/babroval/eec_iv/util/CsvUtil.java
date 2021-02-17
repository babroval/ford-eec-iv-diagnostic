package babroval.eec_iv.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public final class CsvUtil {

	public static List<String> loadAllLinesFromCsvFile(InputStream csvFile) {

		List<String> allLines = new ArrayList<>();
		String line = "";

		try (BufferedReader br = new BufferedReader(new InputStreamReader(csvFile))) {

			if (csvFile.available() < 0) {
				throw new RuntimeException("CSV file is empty");
			}

			int id = 0;
			while ((line = br.readLine()) != null) {

				line = ++id + "," + line;
				allLines.add(line);
			}
			return allLines;

		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
}
