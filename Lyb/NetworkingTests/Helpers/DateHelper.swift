//
//  Helpers.swift
//  NetworkingTests
//
//  Created by Daniel Tombor on 2019. 05. 20..
//  Copyright © 2019. Daniel Tombor. All rights reserved.
//

import Foundation

extension Date {
	var day: DateInterval? {
		return Calendar.current.dateInterval(of: .day, for: self)
	}
}

func getDay(year: Int, month: Int, day: Int) -> DateInterval? {
	return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))?.day
}
