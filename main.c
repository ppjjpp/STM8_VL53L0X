#include "stm8s_gpio.h"
#include "stm8s.h"
#include "i2c_rake.h"
#include "vl53l0x.h"
#include "stm8s_clk.h"

#define LED_GPIO_PORT (GPIOD)
#define LED_GPIO_PIN (GPIO_PIN_3)

u16 pResult;

static void delay(uint32_t t) {
    while(--t);
}


void main(void)
{
	GPIO_DeInit(GPIOD);
	GPIO_Init(LED_GPIO_PORT,LED_GPIO_PIN,GPIO_MODE_OUT_PP_LOW_SLOW);
	I2C_DeInit();
	//I2C_Init()
	I2C_Init(I2C_SPEED, VL53L0X_ADDRESS, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, (CLK_GetClockFreq() / 1000000));
	
	while (1)
	{
		if (pResult = I2C_ByteRead(VL53L0X_ADDRESS, VL53L0X_EXPECTED_DEVICE_ID_ADRESS) == VL53L0X_EXPECTED_DEVICE_ID)
		{
			GPIO_WriteHigh(LED_GPIO_PORT, LED_GPIO_PIN);
		}
	delay(10000);
	}
}

#ifdef USE_FULL_ASSERT

/**
  * @brief  Reports the name of the source file and the source line number
  *   where the assert_param error has occurred.
  * @param file: pointer to the source file name
  * @param line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t* file, uint32_t line)
{
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

  /* Infinite loop */
  while (1)
  {
  }
}
#endif